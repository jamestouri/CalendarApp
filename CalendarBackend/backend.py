from flask import Flask,request, jsonify, current_app
import flask
from werkzeug.contrib.cache import SimpleCache


app = flask.Flask('venv')

class Cache(object):

    cache = SimpleCache(threshold = 1000, default_timeout = 100)
    # cache = MemcachedCache(servers = ['127.0.0.1:11211'], default_timeout = 100, key_prefix = 'my_prefix_')

    @classmethod
    def get(cls, key = None):
        return cls.cache.get(key)

   
    @classmethod
    def set(cls, key = None, value = None, timeout = 0):
        if timeout:
            return cls.cache.set(key, value, timeout = timeout)
        else:    
            return cls.cache.set(key, value)




@app.route('/events', methods = ['POST', 'GET'])
def create_task():
	counter = 0 
	if request.method == 'POST':
	    if not request.json:
	        abort(400)

	    get_events = {
	        'event': request.json['event'],
	        'start_time': request.json['start_time'],
	        'end_time': request.json['end_time'],
	        'day': request.json['day'],
	    }
	    Cache.set(get_events)
	    counter += 1 
	    return jsonify({'event': get_events}), 201
	else:
		if counter == 0:
			pass
		else:
			return jsonify(Cache.get(get_events))




if __name__ == '__main__':
    app.run(debug = True)