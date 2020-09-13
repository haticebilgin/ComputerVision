#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
int main()
{
	Mat image = imread("lena.png");
	namedWindow("image", WINDOW_NORMAL);
	imshow("image", image);
	waitKey(0);


	return 0;
}
