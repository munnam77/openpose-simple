@echo off
rem --- 
rem ---  Convert image data to Openpose skeleton data
rem --- 

rem ---  Change the current directory to the execution destination
cd /d %~dp0

rem ---  Input target image file path
echo Please enter the full path of the directory containing the image to be analyzed.
echo Multiple images can be placed in the directory.
echo This setting is available only for half size alphanumeric characters, it is a required item.
set INPUT_IMAGE_DIR=
set /P INPUT_IMAGE_DIR=** Analysis target image directory path: 
rem echo INPUT_IMAGE_DIR�F%INPUT_IMAGE_DIR%

IF /I "%INPUT_IMAGE_DIR%" EQU "" (
    ECHO Processing is suspended because analysis target image directory path is not set.
    EXIT /B
)

rem ---  Maximum number of people in the image

echo --------------
echo Please enter the maximum number of people shown in the image.
echo If you do not enter anything and press ENTER, it will be analysis for one person.
echo If you specify only one person in the image of which the number of people is the same size, the analysis subject may jump.
set NUMBER_PEOPLE_MAX=1
set /P NUMBER_PEOPLE_MAX="** Maximum number of people in the image: "

rem --echo NUMBER_PEOPLE_MAX: %NUMBER_PEOPLE_MAX%

rem -----------------------------------
rem --- ���͉摜�p�X
FOR %%1 IN (%INPUT_IMAGE_DIR%) DO (
    rem -- ���͉摜�p�X�̐e�f�B���N�g���ƁA�t�@�C����+_json�Ńp�X����
    set INPUT_IMAGE_DIR_PARENT=%%~1\
    set INPUT_IMAGE_DIRNAME=%%~n1
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
set OUTPUT_JSON_DIR=%INPUT_IMAGE_DIR_PARENT%%INPUT_IMAGE_DIRNAME%_%DTTM%\%INPUT_IMAGE_DIRNAME%_json
rem echo %OUTPUT_JSON_DIR%

rem -- JSON�o�̓f�B���N�g������
mkdir %OUTPUT_JSON_DIR%
echo Analysis result JSON directory�F%OUTPUT_JSON_DIR%

rem ------------------------------------------------
rem -- �摜�o�̓f�B���N�g��
set OUTPUT_IMAGE_PATH=%INPUT_IMAGE_DIR_PARENT%%INPUT_IMAGE_DIRNAME%_%DTTM%\%INPUT_IMAGE_DIRNAME%_openpose
echo Analysis result png file�F%OUTPUT_IMAGE_PATH%

echo --------------
echo Start analyzing with Openpose.
echo If you want to interrupt the analysis, please press the ESC key.

rem -- exe���s
bin\OpenPoseDemo.exe --image_dir %INPUT_IMAGE_DIR% --model_pose COCO --write_json %OUTPUT_JSON_DIR% --write_images %OUTPUT_IMAGE_PATH% --number_people_max %NUMBER_PEOPLE_MAX%

echo --------------
echo Done!!
echo The analysis with Openpose is over.
echo !!! Image analysis results can not be applied after 3d-pose-baseline-vmd.
echo %OUTPUT_JSON_DIR%

