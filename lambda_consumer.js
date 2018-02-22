// lambda entry point
const handler = (event, context, cb) => {
  console.log('start');
  console.log('--raw event--', event);
  for(let i = 0; i < event.Records.length; ++i) {
    console.log('Record: ', i);
    const encodedPayload = event.Records[i].kinesis.data
    const payload = new Buffer(encodedPayload, 'base64').toString('utf-8');
    console.log('payload', payload);
  }

	cb(null, null);
};

module.exports = {
		handler
}
