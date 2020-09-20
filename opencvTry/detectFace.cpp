#include <iostream>
#include <opencv2/opencv.hpp>
#include <vector>

using namespace std;
using namespace cv;

int main()
{
	double scale = 1.0;
	CascadeClassifier faceCascade;
	faceCascade.load("haarcascade_frontalface_default.xml");
	namedWindow("video", WINDOW_AUTOSIZE);
	VideoCapture cap(0);

	for (;;)
	{
		Mat frame;
		Mat gray_image;

		cap >> frame;
		cvtColor(frame, gray_image, COLOR_BGR2GRAY);

		vector<Rect> faces;
		faceCascade.detectMultiScale(gray_image, faces, 1.3, 3, 0);

		for (Rect area : faces)
		{
			Scalar drawColor = Scalar(0, 255, 0);
			rectangle(frame, Point(area.x,area.y), Point(area.x+area.width, area.y+area.width),drawColor);
		}

		imshow("Webcam Video", frame);

		if (waitKey(33) >= 0)
			break;
	}
	return 0;
}
