
# Grande

Grande is a small framework. The world surely needs more frameworks, so I went
ahead and created this.

# Get started

Clone this repository and copy the _app\_template_ folder somewhere. This is going
to be your app root folder. Then rename that folder to something truly awesome.

Enter that folder and run:

```
$ bundle install
$ bundle exec puma -p 3000
```

Then watch it say hello to the world by running:

```
$ curl http://localhost:3000/
```

🎉

# Seriously tho

I came across creating small apps in Ruby and I ended up always creating the same
code again and again. So I to created this repo and now I can more quickly create
new apps. It is both *batteries included* and *opinionated*, so beware!

It includes:

- Configuration loading
- A `config.ru` and `config/puma.rb` with forking instructions
- A Gemfile with decent default gems
- An initial folder structure
- Database setup with Sequel, PG and Redis, working out of the box with forking servers
- A `public` folder to serve assets if there should be any
- A rspec skeleton
- Database migration folder structure and rake task. Specific for Sequel

A good foundation for any app to start with in my opinion :-)

The idea is to be simple, so there's no fancy scaffolding code. Instead, a folder
(`app_template`) where one can just copy and paste it and change whatever is needed.

# License

Licensed under the [MIT license](MIT-LICENSE).
