FROM python

ARG REPORT_PATH
ENV env_REPORT_PATH=$REPORT_PATH

# install chrome browser
RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
RUN gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
RUN echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update 
RUN apt-get install -y google-chrome-stable

# create project directory structure
RUN mkdir -p $REPORT_PATH
RUN mkdir -p api-automation-ebird

WORKDIR /api-automation-ebird

# copy source code files
COPY . .

# install dependacy
RUN pip install --no-cache-dir -r requirements.txt

# RUN sh entrypoint.sh
ENTRYPOINT sh entrypoint.sh $env_REPORT_PATH