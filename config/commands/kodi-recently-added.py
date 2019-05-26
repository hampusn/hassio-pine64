#!/usr/bin/env python3

from requests import post
import json

payload_episodes = {
	"jsonrpc": "2.0",
	"method": "VideoLibrary.GetRecentlyAddedEpisodes", 
	"id": 1, 
	"params": {
		"properties": [
			"title",
			"showtitle",
			"dateadded",
			"firstaired",
			"season",
			"episode"
		],
		"limits": {
			"end": 10
		}
	}
}

payload_movies = {
	"jsonrpc": "2.0",
	"method": "VideoLibrary.GetRecentlyAddedMovies", 
	"id": 1, 
	"params": {
		"properties": [
			"title",
      "originaltitle",
      "runtime",
      "dateadded",
      "premiered"
		],
		"limits": {
			"end": 10
		}
	}
}

host = sys.argv[1]
port = sys.argv[2]

response_episodes = post(f'http://{host}:{port}/jsonrpc', json=payload_episodes)
response_movies   = post(f'http://{host}:{port}/jsonrpc', json=payload_movies)

data = {
  "episodes": response_episodes.json()['result']['episodes'],
  "movies":   response_movies.json()['result']['movies']
}

print(json.dumps(data))
