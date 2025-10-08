import os

# 获取当前工作目录作为遍历起点
start_dir = os.getcwd()

# 遍历目录
for root, dirs, files in os.walk(start_dir):
    # 过滤掉以 '.' 开头的子目录
    dirs[:] = [d for d in dirs if not d.startswith('.')]

    # 处理当前目录下的文件
    for file in files:
        if not file.startswith('.'):
            # 构造文件的绝对路径
            file_path = os.path.join(root, file)
            # 构造相对路径
            rel_path = os.path.relpath(file_path, start_dir)
            # 替换反斜杠为正斜杠
            rel_path = rel_path.replace('\\', '/')
            # 输出格式
            print(f"<File>{rel_path}</File>")

