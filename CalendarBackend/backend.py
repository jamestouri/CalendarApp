from flask import Flask, request, jsonify, current_app
import flask
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os




app = Flask('venv')
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'crud.sqlite')

db = SQLAlchemy(app)
ma = Marshmallow(app)




class Event(db.Model):
	id = db.Column(db.Integer, primary_key = True)
	event = db.Column(db.String(120))
	start_time = db.Column(db.String(10))
	end_time = db.Column(db.String(10))
	day = db.Column(db.String(2))
 
	def __init__(self, event, start_time, end_time, day):
		self.event = event
		self.start_time = start_time
		self.end_time = end_time
		self.day = day

class EventSchema(ma.Schema):
	class Meta:
		fields = ('event', 'start_time', 'end_time', 'day')

event_schema = EventSchema()
events_schema = EventSchema(many = True)



@app.route('/events', methods = ['POST', 'GET'])
def create_task():
	if request.method == 'POST':
		data = request.get_json(force = True)
		event = data['event']
		start_time = data['start_time']
		end_time = data['end_time']
		day = data['day']

		new_event = Event(event, start_time, end_time, day)
		result = event_schema.dump(new_event).data
		db.session.add(new_event)
		db.session.commit()
		return jsonify(result)
	else:
		all_users = Event.query.all()
		result = events_schema.dump(all_users)
		return jsonify(result.data)


if __name__ == '__main__':
    app.run(debug = True)






