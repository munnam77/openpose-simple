@echo off
rem --- 
rem ---  �摜�f�[�^���� Openpose���i�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  ���͑Ώۉ摜�t�@�C���p�X
echo ��͑ΏۂƂȂ�摜�������Ă���f�B���N�g���̃t���p�X����͂��ĉ������B
echo �f�B���N�g�����ɂ͕����̉摜��u�����Ƃ��ł��܂��B
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set INPUT_IMAGE_DIR=
set /P INPUT_IMAGE_DIR=����͑Ώۉ摜�f�B���N�g���p�X: 
rem echo INPUT_IMAGE_DIR�F%INPUT_IMAGE_DIR%

IF /I "%INPUT_IMAGE_DIR%" EQU "" (
    ECHO ��͑Ώۉ摜�f�B���N�g���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �摜�ɉf���Ă���ő�l��

echo --------------
echo �摜�ɉf���Ă���ő�l������͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A1�l���̉�͂ɂȂ�܂��B
echo �����l���������x�̑傫���ŉf���Ă���f����1�l�����w�肵���ꍇ�A��͑Ώۂ���ԏꍇ������܂��B
set NUMBER_PEOPLE_MAX=1
set /P NUMBER_PEOPLE_MAX="���摜�ɉf���Ă���ő�l��: "

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
echo ��͌���JSON�f�B���N�g���F%OUTPUT_JSON_DIR%

rem ------------------------------------------------
rem -- �摜�o�̓f�B���N�g��
set OUTPUT_IMAGE_PATH=%INPUT_IMAGE_DIR_PARENT%%INPUT_IMAGE_DIRNAME%_%DTTM%\%INPUT_IMAGE_DIRNAME%_openpose
echo ��͌���png�t�@�C���F%OUTPUT_IMAGE_PATH%

echo --------------
echo Openpose��͂��J�n���܂��B
echo ��͂𒆒f�������ꍇ�AESC�L�[���������ĉ������B

rem -- exe���s
Release\OpenPoseDemo.exe --image_dir %INPUT_IMAGE_DIR% --write_json %OUTPUT_JSON_DIR% --write_images %OUTPUT_IMAGE_PATH% --number_people_max %NUMBER_PEOPLE_MAX%

echo --------------
echo Done!!
echo Openpose��͂��I���܂����B
echo ���摜��͌��ʂ�3d-pose-baseline-vmd �ȍ~�ɂ͓K�p�ł��܂���B
echo %OUTPUT_JSON_DIR%

