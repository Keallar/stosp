# Stosp

## Introduction
Client library for [100sp](https://www.100sp.ru/) API. Supports all proposed endpoints.
## Installation
Add following line to your Gemfile:
```
# Gemfile
gem 'stosp'
```
Or install it system-wide:
```
$ gem install stosp
```
## Usage
First, init client with token:
```
token = 'YOUR_ACCESS_TOKEN'
client = Stosp::Client.new(access_token: token)
```
And than talk API with options (if required):
```
client.purchase_export_meta(purchase)
```
### List of all methods
Check the [official API docs](https://www.100sp.ru/help?category-id=59) for more information and available ```options``` of methods
```
available_distributors -> GET
calculate(options) -> POST
check_orders(mega_order_id, orders = []) -> POST
create(options) -> POST
export_full_report -> GET
export_purchases_list -> GET
import(options) -> POST
process_orders(pid, options = {}) -> GET
purchase_export(options = {}) -> GET
purchase_export_meta(purchase) -> GET
sticker_print(mega_order_ids, options = {}) -> GET
```