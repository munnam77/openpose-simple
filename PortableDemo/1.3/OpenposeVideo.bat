@echo off
rem --- 
rem ---  �f���f�[�^���� Openpose���i�f�[�^�ɕϊ�
rem --- 

rem ---  �J�����g�f�B���N�g�������s��ɕύX
cd /d %~dp0

rem ---  ���͑Ώۉf���t�@�C���p�X
echo ��͑ΏۂƂȂ�f���̃t�@�C���̃t���p�X����͂��ĉ������B
echo 1�t���[���ڂɕK���l�����f���Ă��鎖���m�F���Ă��������B�i�f���ĂȂ��Ǝ��ŃR�P�܂��j
echo ���̐ݒ�͔��p�p�����̂ݐݒ�\�ŁA�K�{���ڂł��B
set INPUT_VIDEO=
set /P INPUT_VIDEO=����͑Ώۉf���t�@�C���p�X: 
rem echo INPUT_VIDEO�F%INPUT_VIDEO%

IF /I "%INPUT_VIDEO%" EQU "" (
    ECHO ��͑Ώۉf���t�@�C���p�X���ݒ肳��Ă��Ȃ����߁A�����𒆒f���܂��B
    EXIT /B
)

rem ---  �f���ɉf���Ă���ő�l��

echo --------------
echo �f���ɉf���Ă���ő�l������͂��ĉ������B
echo �������͂����AENTER�����������ꍇ�A1�l���̉�͂ɂȂ�܂��B
echo �����l���������x�̑傫���ŉf���Ă���f����1�l�����w�肵���ꍇ�A��͑Ώۂ���ԏꍇ������܂��B
set NUMBER_PEOPLE_MAX=1
set /P NUMBER_PEOPLE_MAX="���f���ɉf���Ă���ő�l��: "

rem --echo NUMBER_PEOPLE_MAX: %NUMBER_PEOPLE_MAX%

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
echo ��͌���JSON�f�B���N�g���F%OUTPUT_JSON_DIR%

rem ------------------------------------------------
rem -- �f���o�̓f�B���N�g��
set OUTPUT_VIDEO_PATH=%INPUT_VIDEO_DIR%%INPUT_VIDEO_FILENAME%_%DTTM%\%INPUT_VIDEO_FILENAME%_openpose.avi
echo ��͌���avi�t�@�C���F%OUTPUT_VIDEO_PATH%

echo --------------
echo Openpose��͂��J�n���܂��B
echo ��͂𒆒f�������ꍇ�AESC�L�[���������ĉ������B
echo --------------

rem -- exe���s
bin\OpenPoseDemo.exe --video %INPUT_VIDEO% --write_json %OUTPUT_JSON_DIR% --write_video %OUTPUT_VIDEO_PATH% --number_people_max %NUMBER_PEOPLE_MAX% 

echo --------------
echo Done!!
echo Openpose��͂��I���܂����B
echo 3d-pose-baseline-vmd �Ŏw�肷��JSON�f�B���N�g���t���p�X�͈ȉ��ɂȂ�܂��B
echo %OUTPUT_JSON_DIR%

