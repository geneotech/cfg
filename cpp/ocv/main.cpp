#include <stdio.h>
#include <string>
#include <opencv2/opencv.hpp>

#include <fstream>

#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>

#define PLATFORM_UNIX 1
#if PLATFORM_UNIX
#define _popen popen
#define _pclose pclose
#endif

#define LOGGING 0

const auto target_folder = "Assets";
const auto omit_cropping_of = "";

namespace augs {
	std::string exec(const std::string cmd) {
		std::array<char, 128> buffer;
		std::string result;
		std::shared_ptr<FILE> pipe(_popen(cmd.c_str(), "r"), _pclose);

		if (!pipe) {
			throw std::runtime_error("popen() failed!");
		}

		while (!feof(pipe.get())) {
			if (fgets(buffer.data(), 128, pipe.get()) != NULL) {
				result += buffer.data();
			}
		}

		const bool remove_trailing_newline_for_convenience = 
			result.size() > 0 && result.back() == '\n'
		;

		if (remove_trailing_newline_for_convenience) {
			result.pop_back();
		}

		return result;
	}
}

std::ifstream::pos_type filesize(const std::string filename)
{
    std::ifstream in(filename, std::ifstream::ate | std::ifstream::binary);
    return in.tellg(); 
}

std::string readable_bytesize(const std::size_t _size) {
	double size = static_cast<double>(_size);

	int i = 0;
	const char* units[] = { "B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" };
	while (size > 1000) {
		size /= 1000;
		i++;
	}

	return std::to_string(size) + " " + std::string(units[i]);
}

#include <experimental/filesystem>

using namespace cv;

using path_type = std::experimental::filesystem::path;

template <class D, class F>
void for_each_in_directory_recursive(
	const path_type& dir_path,
	D directory_callback,
	F file_callback
) {
	using namespace std::experimental::filesystem;

	for (recursive_directory_iterator i(dir_path), end; i != end; ++i) {
		const auto p = i->path();

		if (is_directory(p)) {
			directory_callback(p);
		}
		else {
			file_callback(p);
		}
	}
}

using namespace std;

namespace fs = std::experimental::filesystem;

int rgba_that_werent_trimmed = 0;

std::optional<cv::Rect> cut_empty_edges(cv::Mat& source) {
	if (source.channels() == 4) {
		std::vector<cv::Mat> channels;

		cv::split(source, channels);               // seperate channels
		cv::Rect r = boundingRect(channels[3]); // find boundingRect of alpha channel

		source = source(r);

		if (r.x == 0 && r.y == 0 && r.width == source.cols && r.height == source.rows) {
			++rgba_that_werent_trimmed;

			return std::nullopt;
		}

		return r;
	}

	return std::nullopt;
}


std::string file_to_string(std::string path) {
	if (!fs::exists(path)) {

		return "";
	}

	std::ifstream t(path);
	std::stringstream buffer;
	buffer << t.rdbuf();

	return buffer.str();
}

bool ends_with(const std::string& value, const std::string& ending) {
	if (ending.size() > value.size()) {
		return false;
	}

	return std::equal(ending.rbegin(), ending.rend(), value.rbegin());
}
int main()
{
	int total_images = 0;
	int total_metas = 0;

	int total_pre_bytes = 0;
	int total_post_bytes = 0;

	int total_trimmed_images = 0;

	int pixels_saved = 0;

	auto process_image = [&](const auto& p) {
		const auto outputpath = path_type("results") / path_type(p);

		{
			auto withoutfname = outputpath;

			withoutfname.replace_filename("");
			fs::create_directories(withoutfname);
		}

		Mat image;
		image = cv::imread( p, IMREAD_UNCHANGED );

		const auto prev_cols = double(image.cols);
		const auto prev_rows = double(image.rows);

		const auto prev_size = prev_cols * prev_rows;

		auto meta_path = p;
		meta_path.replace_extension(".png.meta");

		const auto outputmetapath = path_type("results") / meta_path;

		auto save_meta = [&]() {
			fs::copy(meta_path, outputmetapath);
		};

		auto save_png = [&]() {
			vector<int> compression_params;
			compression_params.push_back(IMWRITE_PNG_COMPRESSION);
			compression_params.push_back(9);

			cv::imwrite(outputpath, image, compression_params);
		};

		if (string(omit_cropping_of).size() > 0 && p.string().find(omit_cropping_of) != std::string::npos) {
			std::cout << "Omitting cropping of " << p << std::endl;
			save_png();
			save_meta();
		}
		else {
			const auto cropped = cut_empty_edges(image);

			const auto new_size = image.cols * image.rows;
			const auto total_trimmed = prev_size - new_size;
			pixels_saved += total_trimmed;

			save_png();

			if (!fs::exists(meta_path)) {
				std::cout << "Error! " << meta_path << " Does not exist.";
			}
			else {
				save_meta();

				if (cropped) {
					++total_trimmed_images;

					const auto numbers = augs::exec("cat \"" + meta_path.string() + "\" | ag \"spritePivot\" | sed 's/[^\\. 0-9]*//g'");
					std::istringstream ss(numbers);

					double x = 0, y = 0;
					ss >> x >> y;

					const auto prev_cx = prev_cols * x;
					const auto prev_cy = prev_rows * y;

#if LOGGING
					std::cout << x << " " << y << endl;
					std::cout << prev_cx << " " << prev_cy << "( " << (prev_rows - prev_cy) << ")" << endl;
#endif

					const auto& r = *cropped;

					const auto next_cx = prev_cx - r.x;
					const auto next_cy = prev_cy - (prev_rows - (r.y + r.height));

					const auto next_cols = double(image.cols);
					const auto next_rows = double(image.rows);
#if LOGGING
					std::cout << "Initial: " << prev_cols << "x" << prev_rows << endl;
					std::cout << "Cropped: " << next_cols << "x" << next_rows << endl;
					std::cout << "r: " << r.x << " " << r.y << " " << r.width << " " << r.height << endl;
#endif

					const auto next_x_coord = next_cx / next_cols;
					const auto next_y_coord = next_cy / next_rows;

#if LOGGING
					std::cout << "Changed to: " << endl;

					std::cout << next_x_coord << " " << next_y_coord << endl;
					std::cout << next_cx << " " << next_cy << " (" << (next_rows - next_cy) << ")" << endl;

					std::cout << "Trimmed " << prev_cols - image.cols << "x" << prev_rows - image.rows << " (" << total_trimmed << " pixels)" << endl;
#endif

					std::ostringstream coords;
					coords << "x: " << next_x_coord << ", y: " << next_y_coord;

					std::string sed_cmd = 
						"sed -i 's/.*spritePivot.*/  spritePivot: {"
						+ coords.str()
						+ "}/g' \"" + outputmetapath.string() + "\""
					;

					std::system(sed_cmd.c_str());
					//std::cout << sed_cmd << endl;
				}
			}
		}

		auto intermediatepath = outputpath; 

		auto pngquant_command = std::string("pngquant 200 --force --strip --speed 1 \"");

		pngquant_command += intermediatepath.string();
		pngquant_command += "\" --output \"";
		pngquant_command += outputpath.string();
		pngquant_command += "\"";

		std::system(pngquant_command.c_str());
		//std::cout << pngquant_command << endl;


		return outputpath;
	};

	for_each_in_directory_recursive(
		target_folder,
		[&](const auto& p) {

		},
		[&](const auto& p) {
			if (ends_with(p.filename().string(), ".png.meta")) {
				++total_metas;
			}
			else if (p.extension() == ".png") {
				++total_images;
				total_pre_bytes += filesize(p);

				std::cout << "[" << total_images << "] " << p.string() << std::endl;

				const auto outp = process_image(p);
#if LOGGING
				std::cout << "Output path: " << outp << std::endl;
#endif
				total_post_bytes += filesize(outp);
			}
		}
	);

	std::cout << "Total number of images: " << total_images << std::endl;
	std::cout << "Total number of metas: " << total_metas << std::endl;

	std::cout << "Total size of images (pre): " << readable_bytesize(total_pre_bytes) << std::endl;
	std::cout << "Total size of images (post): " << readable_bytesize(total_post_bytes) << std::endl;

	std::cout << "Total trimmed images: " << total_trimmed_images << std::endl;
	std::cout << "Total RGBA images that were not trimmed: " << rgba_that_werent_trimmed << std::endl;

	std::cout << "Pixels saved: " << pixels_saved << " (MB as RGBA: " << readable_bytesize(pixels_saved * 4) << ")" << std::endl;

    return 0;
}

