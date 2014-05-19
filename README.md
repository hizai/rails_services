# Gnuine Rails Services

## General notes

* Whenever a service involves more than one file all its dependencies are saved into a folder with the service name. It is not he folder container itself the one that must be pasted into the app services folder but its contents.

* Service objects are a useful method to refactor fat ActiveRecord Models. More about this subject can be read for instance in this [codeclimate blog post][codeclimate_post]

[codeclimate_post]: http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/