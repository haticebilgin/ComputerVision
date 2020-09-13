#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
int main()
{
	//CV_LOAD_IMAGE_GRAYSCALE and CV_LOAD_IMAGE_COLOR are not defined anymore
	//and should be replaced by cv::IMREAD_COLOR and cv::IMREAD_GRAYSCALE respectively.

	Mat original = imread("lena.png", IMREAD_GRAYSCALE);
	Mat modified = imread("lena.png", IMREAD_GRAYSCALE);


	for (int r = 0; r < modified.rows; r++)
	{
		for (int c = 0; c < modified.cols; c++)
		{
			modified.at<uint8_t>(r, c) = modified.at<uint8_t>(r, c)*0.5;
		}
	}


	imshow("original", original);
	imshow("modified", modified);

	waitKey(0);

	return 0;
}
