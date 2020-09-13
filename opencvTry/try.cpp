#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
int main()
{
	namedWindow("video", WINDOW_AUTOSIZE );
	VideoCapture cap(0);

	Mat frame;
	for (;;)
	{
		cap >> frame;
		imshow("video", frame);
		if (waitKey(33) >= 0)
			break;
	}
	
	return 0;
}