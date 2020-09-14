module Fractional;

import std.stdio;
import std.algorithm;
import std.range;
import core.runtime;
import core.thread;
import std.string;
import std.utf;
import std.conv;

import numFunction;
import polynomial;
import simpleDifEq;
import ExtraMath;

auto toUTF16z(S)(S s)
{
    return toUTFz!(const(wchar)*)(s);
}

import std.math;

pragma(lib, "gdi32.lib");

import core.sys.windows.windef;
import core.sys.windows.winuser;
import core.sys.windows.wingdi;
import core.sys.windows.wingdi;

extern (Windows)
int WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int iCmdShow)
{

	int result;

    try
    {
        Runtime.initialize();
        result = myWinMain(hInstance, hPrevInstance, lpCmdLine, iCmdShow);
        Runtime.terminate();
    }
    catch (Throwable o)
    {
        MessageBox(null, o.toString().toUTF16z, "Error", MB_OK | MB_ICONEXCLAMATION);
        result = 0;
    }

    return result;
}

int myWinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int iCmdShow)
{
    string appName = "SineWave";

    HWND hwnd;
    MSG  msg;
    WNDCLASS wndclass;

    wndclass.style         = CS_HREDRAW | CS_VREDRAW;
    wndclass.lpfnWndProc   = &WndProc;
    wndclass.cbClsExtra    = 0;
    wndclass.cbWndExtra    = 0;
    wndclass.hInstance     = hInstance;
    wndclass.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
    wndclass.hCursor       = LoadCursor(NULL, IDC_ARROW);
    wndclass.hbrBackground = cast(HBRUSH) GetStockObject(WHITE_BRUSH);

    wndclass.lpszMenuName  = NULL;
    wndclass.lpszClassName = appName.toUTF16z;

    if (!RegisterClass(&wndclass))
    {
        MessageBox(NULL, "This program requires Windows NT!", appName.toUTF16z, MB_ICONERROR);
        return 0;
    }

    hwnd = CreateWindow(appName.toUTF16z,            // window class name
                        "Sine Wave Using Polyline",  // window caption
                        WS_OVERLAPPEDWINDOW,         // window style
                        CW_USEDEFAULT,               // initial x position
                        CW_USEDEFAULT,               // initial y position
                        CW_USEDEFAULT,               // initial x size
                        CW_USEDEFAULT,               // initial y size
                        NULL,                        // parent window handle
                        NULL,                        // window menu handle
                        hInstance,                   // program instance handle
                        NULL);                       // creation parameters

    ShowWindow(hwnd, iCmdShow);
    UpdateWindow(hwnd);

    while (GetMessage(&msg, NULL, 0, 0))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return msg.wParam;
}

enum NUM  = 1000;
int shiftX;
int shiftY;
uint xPos;
uint yPos;
int translateX = 0;
int translateY = 0;
int tempTranslateX = 0;
int tempTranslateY = 0;
bool mousedown = false;
int scale = 160;
int frames = 0;

POINT[NUM] apt;
POINT[NUM] apt_t;
POINT lastLocation;

HPEN smallPen;
HPEN medPen;
HPEN bigPen;

ExtraMath extraMath;

//FUNCTIONS

polynomial func;
simpleDifEq diffEQ;

extern (Windows)
LRESULT WndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) nothrow
{
    scope (failure) assert(0);

    static int cxClient, cyClient;
    shiftX = cxClient/2 + tempTranslateX + translateX;
	shiftY = cyClient/2 + tempTranslateY + translateY;
    double[] waveform;
    HDC hdc;
    PAINTSTRUCT ps;
	extraMath = new ExtraMath();
	apt_t = apt;

	numFunction honk = new numFunction(NUM);
	waveform = *honk.getValues();

    switch (message)
    {
		case WM_CREATE:
			{
				smallPen = CreatePen(PS_SOLID, 1, RGB(230,230,230));
				medPen = CreatePen(PS_SOLID, 1, RGB(153,153,153));
				bigPen = CreatePen(PS_SOLID, 2, RGB(0,0,0));

				//FUNCTIONS

				func = new polynomial(1,.5);
				func.addTerm(1,2);

				func = extraMath.combinePolynomial(func, new polynomial(1,2));

				//DIFFERENTIAL EQUATIONS

				diffEQ = extraMath.buildFractionDifEqRL(1, 0, 1.5);

			}
        case WM_SIZE:
			{
				cxClient = LOWORD(lParam);
				cyClient = HIWORD(lParam);

				//CALCULATE FUNCTIONS

				//FUNCTION 1

				double upperBound = 10;
				double lowerBound = -10;

				foreach (index; 0 .. NUM)
				{
				    double variable = index-NUM/2;
				    apt[index].x = cxClient/2 + cast(int)((upperBound - lowerBound)*variable/NUM*scale);
					apt[index].y = cyClient/2 - cast(int)(scale * func.evaluate((apt[index].x - cxClient/2)/(cast(double)scale)));


				    try{
				    }
				    catch(Throwable o)
				    {
				        MessageBox(null, o.toString().toUTF16z, "Error", MB_OK | MB_ICONEXCLAMATION);
				    }
				}

				//FUNCTION 2

				return 0;
			}
		case WM_LBUTTONDOWN: 
			{
                //MessageBox(null, "honk".toUTF16z, "Error", MB_OK | MB_ICONEXCLAMATION);
			    mousedown = true;

				lastLocation.x = cast(uint)cast(short)LOWORD(lParam);
				lastLocation.y = cast(uint)cast(short)HIWORD(lParam);

                //MessageBox(null, to!string(lastLocation.x).toUTF16z, "Error", MB_OK | MB_ICONEXCLAMATION);

			    return 0;
		    }
		case WM_LBUTTONUP: 
			{
                //MessageBox(null, "honk".toUTF16z, "Error", MB_OK | MB_ICONEXCLAMATION);
				mousedown = false;
				translateX += tempTranslateX;
				translateY += tempTranslateY;
				tempTranslateX = 0;
				tempTranslateY = 0;
				InvalidateRgn(hwnd, NULL, TRUE);

				return 0;
			}
		case WM_MOUSEMOVE: 
			{

				xPos = cast(uint)cast(short)LOWORD(lParam);
				yPos = cast(uint)cast(short)HIWORD(lParam);

			    if (mousedown) {
				    tempTranslateX =  cast(int)((cast(int)xPos) - lastLocation.x);
				    tempTranslateY =  cast(int)((cast(int)yPos) - lastLocation.y);
					InvalidateRgn(hwnd, NULL, TRUE);
			    }

				InvalidateRgn(hwnd, NULL, TRUE);
				Thread.sleep(dur!("msecs")(30));
				
		        //return 0;
		    }

        case WM_PAINT:
			{

				hdc = BeginPaint(hwnd, &ps);

				//Rectangle(hdc, 0, 0, cxClient, cyClient);

                //MAKE GRID

                int gridPoints;

				auto honkhonk = toUTFz!(const(char)*)(to!string("honk"));
				TextOutA(hdc,200,170, honkhonk, 4);

                //SMOL GRID

				HPEN hSmolGridPen = SelectObject(hdc, smallPen);

				scale = scale / 4;
				
				gridPoints = cast(int)(2 * (cxClient/scale) + 2);
				for(int i = 0; i < gridPoints; i++) {
					int grid = scale * (i + 1);
				    MoveToEx(hdc, shiftX - grid, cyClient, NULL);
				    LineTo(hdc, shiftX - grid, 0);
				    MoveToEx(hdc, shiftX + grid, cyClient, NULL);
				    LineTo(hdc, shiftX + grid, 0);
				}
				
				gridPoints = cast(int)(2 * (cyClient/scale) + 2);
				for(int i = 0; i < gridPoints; i++) {
					int grid = scale * (i + 1);
				    MoveToEx(hdc, cxClient, shiftY + grid, NULL);
				    LineTo(hdc, 0, shiftY + grid);
				    MoveToEx(hdc, cxClient, shiftY - grid, NULL);
				    LineTo(hdc, 0, shiftY - grid);
				}
				
				scale = scale * 4;
				
				//MEDIUM GRID
				
				HPEN hMedGridPen = SelectObject(hdc, medPen);
				
				gridPoints = cast(int)(2 * (cxClient/scale) + 2);
				for(int i = 0; i < gridPoints; i++) {
					int grid = scale * (i + 1);
				    MoveToEx(hdc, shiftX - grid, cyClient, NULL);
				    LineTo(hdc, shiftX - grid, 0);
				    MoveToEx(hdc, shiftX + grid, cyClient, NULL);
				    LineTo(hdc, shiftX + grid, 0);
				}
				
				gridPoints = cast(int)(2 * (cyClient/scale) + 2);
				for(int i = 0; i < gridPoints; i++) {
					int grid = scale * (i + 1);
				    MoveToEx(hdc, cxClient, shiftY + grid, NULL);
				    LineTo(hdc, 0, shiftY + grid);
				    MoveToEx(hdc, cxClient, shiftY - grid, NULL);
				    LineTo(hdc, 0, shiftY - grid);
				}
				
				//LARGE GRID

                HPEN hLargeGridPen = SelectObject(hdc, bigPen);

				MoveToEx(hdc, 0, shiftY, NULL);
				LineTo(hdc, cxClient, shiftY);
                MoveToEx(hdc, shiftX, 0, NULL);
                LineTo(hdc, shiftX, cyClient);


				//LEGEND

				Rectangle(hdc, 8, 8, 160, 40);
				TextOutA(hdc,16,16, toUTFz!(const(char)*)(to!string(cast(double)(cast(int)xPos - shiftX)/scale)), 6);
				TextOutA(hdc,88,16, toUTFz!(const(char)*)(to!string(-cast(double)(cast(int)yPos - shiftY)/scale)), 6);

				TextOutA(hdc,88,160, toUTFz!(const(char)*)((diffEQ.toString())), diffEQ.toString().length);


				//FUNCTION ADJUST

				for(int index = 0; index < NUM; index++) {
					apt_t[index].x += shiftX - cxClient/2;
					apt_t[index].y += shiftY - cyClient/2;
				}

				//PLOT FUNCTION

				Polyline(hdc, apt_t.ptr, NUM);
				EndPaint(hwnd, &ps);
				return 0;
			}

        case WM_DESTROY:
			{
                
                //MessageBox(NULL, (to!string(cxClient)).toUTF16z, "honk".toUTF16z, MB_ICONERROR);
                //MessageBox(NULL, (to!string(cyClient)).toUTF16z, "honk".toUTF16z, MB_ICONERROR);
				PostQuitMessage(0);
				return 0;
			}

        default:
    }

    return DefWindowProc(hwnd, message, wParam, lParam);
}