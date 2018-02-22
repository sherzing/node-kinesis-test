'use strict';
const config = require('./config');
const aws = require("aws-sdk");


const kinesis = new aws.Kinesis({ region: 'eu-west-1', apiVersion: '2013-12-02' });

const kinesisPutRecord = params => new Promise((resolve, reject) => {
	console.log('put record: ', params )
	kinesis.putRecord(params, (err, data) => {
		if (err) {
			return reject(err);
		}
		resolve(data);
	});
});

const writeKinesis = (raw) => {
	console.log('raw data: ', raw)
	const data = JSON.stringify(raw);
	const params = { Data: data, PartitionKey: 'shard', StreamName: 'testing-stream' };
	return kinesisPutRecord(params);
};

const producer = async () => {
	console.log('in producer');

    // smiple record
	let records = [];

	for (let i = 0; i < 10; i++) {
	  records.push({ key : i, sample: 'anytest'});
		console.log('records: ', records);
		const results = await writeKinesis(records);
	}

	return Object.keys(results).length;

};

const handler = (event, context, cb) => {
	producer().then((res) => {
		cb(null, res);
	}, (err) => {
		cb(err);
	});
};

module.exports = {
		handler
}
