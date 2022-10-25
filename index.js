const AWS = require('aws-sdk');
const S3 = new AWS.S3({region: process.env.AWS_REGION, apiVersion: '2012-10-17'});

exports.handler = async (event) => {
    if(event.Records.length > 0) {
        for(let record in event.Records) {
            let jsonOutput = event.Records[record].body;
            
            const eventId = JSON.parse(jsonOutput).detail.EVENT_ID;
            console.log('Received event from Lacework with ID: ', eventId);

            // call the function to write the data to the S3 bucket
            const result = await putObjectS3(JSON.stringify(jsonOutput), eventId);
            return result;
        }
    }
};

const putObjectS3 = (data, nameOfFile) => {
  return new Promise((resolve, reject) => {
    //Write to file
    var s3 = new AWS.S3();
    var params = {
        Bucket : process.env.S3_BUCKET_NAME,
        Key : nameOfFile + ".json",
        Body : data
    }
    s3.putObject(params, function (err, result) {
      if(err) {
          console.log(err); // an error occurred
          reject(err);
      }
      if(result) {
          console.log("Put to s3 completed"); // successful response
          resolve(result);
      }
    });
  });
}
