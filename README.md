# README

<!-- This README would normally document whatever steps are necessary to get the
application up and running.
Things you may want to cover:
* Ruby version
* System dependencies
* Configuration
* Database creation
* Database initialization
* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions
* ... -->

# アプリ名
wizard_app

# URL
https://wizard-app-20201226.herokuapp.com/

# 説明

devise機能を編集し、ウィザード形式（対話するように順番に操作が進んでいく方式）で新規登録をすることができます。


# テーブル設計

## users テーブル

| Column   | Type    | Options     |
| :------- | :-----  | :---------- |
| name     | string  | null: false |
| age      | integer | null: false |
| email    | string  | null: false |
| password | string  | null: false |

### Association

- has_one :address

<br>

## addresses テーブル

| Column      | Type      | Options        |
| :---------- | :-------  | :------------- |
| postal_code | integer   |                |
| address     | text      |                |
| user_id     | reference | optional: true |


### Association

- belongs_to :user

