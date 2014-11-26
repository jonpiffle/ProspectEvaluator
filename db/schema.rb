# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141126195320) do

  create_table "news", force: true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "source"
    t.text     "description"
    t.integer  "player_id"
    t.datetime "date_posted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "html"
    t.text     "body"
    t.float    "sentiment_score"
    t.text     "chunked_body"
  end

  add_index "news", ["url"], name: "index_news_on_url", unique: true

  create_table "players", force: true do |t|
    t.string   "position"
    t.string   "hometown"
    t.string   "college_class"
    t.string   "reach"
    t.string   "wingspan"
    t.string   "age"
    t.string   "date_of_birth"
    t.string   "college"
    t.string   "height"
    t.string   "weight"
    t.string   "photo_url"
    t.string   "espn_overall_rank"
    t.string   "espn_position_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "twitter_handle"
    t.text     "keywords"
  end

  create_table "tweet_abouts", force: true do |t|
    t.string   "text"
    t.string   "tweet_id"
    t.datetime "tweet_time"
    t.string   "tweeted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.float    "sentiment_score"
  end

  add_index "tweet_abouts", ["text"], name: "index_tweet_abouts_on_text", unique: true
  add_index "tweet_abouts", ["tweet_id"], name: "index_tweet_abouts_on_tweet_id", unique: true

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "tweet_id"
    t.datetime "tweet_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
    t.float    "sentiment_score"
  end

  add_index "tweets", ["text"], name: "index_tweets_on_text", unique: true
  add_index "tweets", ["tweet_id"], name: "index_tweets_on_tweet_id", unique: true

end
