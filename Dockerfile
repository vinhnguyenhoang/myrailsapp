# Sử dụng image Ruby chính thức
FROM ruby:3.2.2

# Cài đặt các dependencies cần thiết
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Thiết lập thư mục làm việc
WORKDIR /myrailsapp

# Sao chép Gemfile và Gemfile.lock vào container
COPY Gemfile Gemfile.lock /myrailsapp/

# Cài đặt các gems
RUN bundle install

# Sao chép toàn bộ mã nguồn vào container
COPY . /myrailsapp

# Expose port 3000
EXPOSE 3000

# Lệnh khởi động ứng dụng
CMD ["rails", "server", "-b", "0.0.0.0"]
