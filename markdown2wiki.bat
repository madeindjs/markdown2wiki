@echo off

set OUT_PATH=%~dpn1.txt

echo �ϊ����J�n���܂��B
echo   �ϊ�����t�@�C���F%~nx1
pause

ruby libs\markdown2wiki.rb %1 %OUT_PATH%

echo �ϊ����I�����܂����B
echo   �ϊ����ʁF%~n1.txt
pause