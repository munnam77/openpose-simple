@echo off
rem --- 
rem ---  Convert video data to Openpose skeleton data
rem --- 

rem ---  Change the current directory to the execution destination
cd /d %~dp0

rem ---  Input target video file path
echo Please enter the full path of the file of the video to be analyzed.
echo Please make sure that people are reflected in the first frame. (If it does not show it will fail next time)
echo This setting is available only for half size alphanumeric characters, it is a required item.
set INPUT_VIDEO=
set /P INPUT_VIDEO=** Analysis target video file path: 
rem echo INPUT_VIDEO�F%INPUT_VIDEO%

IF /I "%INPUT_VIDEO%" EQU "" (
    ECHO Processing is suspended because the analysis target video file path is not set.
    EXIT /B
)

rem ---  Frame to start analysis

echo --------------
echo Please enter the frame number for starting analysis. (0 start)
echo If the human body can not trace accurately, 
echo such as when the logo is displayed at the beginning, you can skip the beginning frame.
echo If nothing is entered and ENTER is pressed, it will be analyzed from 0F.
set FRAME_FIRST=0
set /P FRAME_FIRST="** Analysis start frame number: "

rem ---  Maximum number of people in the image

echo --------------
echo Please enter the maximum number of people shown in the image.
echo If you do not enter anything and press ENTER, it will be analysis for one person.
echo If you specify only one person in the image of which the number of people is the same size, the analysis subject may jump.
set NUMBER_PEOPLE_MAX=1
set /P NUMBER_PEOPLE_MAX="** Maximum number of people shown in the image:"

rem -----------------------------------
rem --- ���͉f���p�X
FOR %%1 IN (%INPUT_VIDEO%) DO (
    rem -- ���͉f���p�X�̐e�f�B���N�g���ƁA�t�@�C����+_json�Ńp�X����
    set INPUT_VIDEO_DIR=%%~dp1
    set INPUT_VIDEO_FILENAME=%%~n1
)

rem -- ���s���t
set DT=%date%
rem -- ���s����
set TM=%time%
rem -- ���Ԃ̋󔒂�0�ɒu��
set TM2=%TM: =0%
rem -- ���s�������t�@�C�����p�ɒu��
set DTTM=%dt:~0,4%%dt:~5,2%%dt:~8,2%_%TM2:~0,2%%TM2:~3,2%%TM2:~6,2%

echo --------------

rem ------------------------------------------------
rem -- JSON�o�̓f�B���N�g��
set OUTPUT_JSON_DIR=%INPUT_VIDEO_DIR%%INPUT_VIDEO_FILENAME%_%DTTM%\%INPUT_VIDEO_FILENAME%_json
rem echo %OUTPUT_JSON_DIR%

rem -- JSON�o�̓f�B���N�g������
mkdir %OUTPUT_JSON_DIR%
echo Analysis result JSON directory�F%OUTPUT_JSON_DIR%

rem ------------------------------------------------
rem -- �f���o�̓f�B���N�g��
set OUTPUT_VIDEO_PATH=%INPUT_VIDEO_DIR%%INPUT_VIDEO_FILENAME%_%DTTM%\%INPUT_VIDEO_FILENAME%_openpose.avi
echo Analysis result avi file�F%OUTPUT_VIDEO_PATH%

echo --------------
echo Start analyzing with Openpose.
echo If you want to interrupt the analysis, please press the ESC key.
echo --------------

rem -- exe���s
bin\OpenPoseDemo.exe --video %INPUT_VIDEO% --model_pose COCO --write_json %OUTPUT_JSON_DIR% --write_video %OUTPUT_VIDEO_PATH% --number_people_max %NUMBER_PEOPLE_MAX% --frame_first %FRAME_FIRST%

echo --------------
echo Done!!
echo The analysis with Openpose is over.
echo The full path of the JSON directory specified by 3d-pose-baseline-vmd is as follows.
echo %OUTPUT_JSON_DIR%
