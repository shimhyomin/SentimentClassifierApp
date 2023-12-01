import tweepy
import csv

# 트위터 API에 접근하기 위한 개인 키를 입력
consumer_key = "VLiB0qLJ5jrjH0eg4QNt79b0h"
consumer_secret = "XJ0NCBsn3g94f2h7DeJ4QU8Sl5dxp5tbrNaMUg7zqH0JSc1k24"

access_token = "1502949979308294145-J5CQI0ChQnUjtk9dLEr2aTrmVf3bo8"
access_token_secret = "bsqC2zjrTg8LX7gGC6AcJcjGqXgSfnvmULlDa0ghrZWWh"

# OAuth 핸들러 생성 & 개인정보 인증 요청
auth = tweepy.OAuthHandler(consumer_key, consumer_secret)

# 액세스 요청
auth.set_access_token(access_token, access_token_secret)

# api instace 생성
api = tweepy.API(auth)

fileName = "tweetData_Pos.csv"
#fileName = "tweetData_Neg.csv"
#fileName = "tweetData_Neutral.csv"
f = open(fileName, "w", encoding='utf-8-sig')
wr = csv.writer(f)
dic = { "text":"name" }

## Method for Searches
print("Searching by keyword")
keyword = " 🥹 "
#keyword = " 🤬 "
#keyword = " 🤔 "
for tweet in api.search_tweets(q=keyword, lang="ko", result_type = "recent", count=100):
    #print(f"{tweet.user.name}:{tweet.text}")
    dic[tweet.text] = tweet.user.name
    
for text, name in dic.items():
    wr.writerow([text, name])

f.close()

