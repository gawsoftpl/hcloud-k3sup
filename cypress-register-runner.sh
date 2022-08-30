while ! ping -c 1 -W 1 gitlab-runner-downloads.s3.amazonaws.com; do
    echo "Waiting for network - network interface might be down..."
    sleep 1
done

# Download the binary for your system
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start

gitlab-runner register \
--url $1 \
--registration-token $2 \
--tag-list $3 \
--non-interactive \
--executor docker \
--docker-image=ruby:2.7