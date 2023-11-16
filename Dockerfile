FROM alpine:latest
WORKDIR /app

RUN apk update
RUN apk add bash && bash
RUN apk add --no-cache build-base cmake gtkmm4-dev pkgconfig gtk4.0-dev gtk+2.0-dev python3 py3-pip
RUN pip install pipx
RUN pipx ensurepath
RUN exec bash
RUN pipx install conan

RUN pipx ensurepath

RUN cat /root/.bashrc
COPY . /app

RUN cmake -B build -S . -DCMAKE_PROJECT_TOP_LEVEL_INCLUDES=./conan_provider.cmake -DCMAKE_BUILD_TYPE=Release
RUN ["cmake", "--build", "build"]
