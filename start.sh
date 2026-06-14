#!/usr/bin/env bash
set -e

# Homebrew Ruby(3.x)를 사용 (시스템 Ruby 2.6에는 bundler 2.6.9가 없음)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# SCSS 등 UTF-8 파일을 읽기 위해 로케일을 UTF-8로 설정
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# 의존성 설치 (이미 설치돼 있으면 빠르게 통과)
bundle install

# jekyll liveserve(hawkins)는 최신 webrick과 호환되지 않아 500 에러가 나므로
# jekyll 내장 라이브리로드를 사용한다.
bundle exec jekyll serve --host 127.0.0.1 --port 4000 --livereload
