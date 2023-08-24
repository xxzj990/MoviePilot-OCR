FROM ubuntu:latest
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    REPO_URL="https://github.com/jxxghp/MoviePilot-OCR.git" \
    WORKDIR="/app"
RUN apt-get update && apt-get install -y wget git ffmpeg libgomp1 libsm6 libxrender1 libxext6 libgl1 python3 python3-pip \
    && wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb \
    && dpkg -i libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb
RUN git clone -b main ${REPO_URL} ${WORKDIR}
WORKDIR ${WORKDIR}
RUN pip3 install -r requirements.txt
EXPOSE 9899
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9899"]
