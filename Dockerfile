FROM python

ARG REPORT_PATH
ENV env_REPORT_PATH=$REPORT_PATH

RUN mkdir -p $REPORT_PATH
RUN mkdir -p api-automation-ebird

WORKDIR /api-automation-ebird

# copy source code files
COPY . .

# install dependacy
RUN pip install --no-cache-dir -r requirements.txt

# RUN sh entrypoint.sh
ENTRYPOINT sh entrypoint.sh $env_REPORT_PATH