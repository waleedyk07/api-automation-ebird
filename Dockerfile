FROM python

RUN mkdir -p test-results
RUN mkdir -p api-automation-ebird

WORKDIR /api-automation-ebird

# copy source code files
COPY . .

# install dependacy
RUN pip install --no-cache-dir -r requirements.txt

# RUN sh entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]