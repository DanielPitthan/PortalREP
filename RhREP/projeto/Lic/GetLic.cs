using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.IO;

using Newtonsoft.Json;

namespace GetLicLibray
{
    public class GetLic
    {
        private string key;       
        private JsonResultResponse result;


        public GetLic(string _key)
        {
            this.key = _key;
            ObterLicensa();
        }

        public JsonResultResponse Get()
        {
            return result;
        }

        private void ObterLicensa()
        {
            WebRequest request = WebRequest.Create("http://178.33.107.111:10800/api/LicenseControl");
            // Set the Method property of the request to POST.
            request.Method = "POST";

            // Create POST data and convert it to a byte array.
            string postData = "{\r\n    \"AccessKey\": \""+this.key+"\"\r\n}";
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            // Set the ContentType property of the WebRequest.
            request.ContentType = "application/json";
            // Set the ContentLength property of the WebRequest.
            request.ContentLength = byteArray.Length;

            // Get the request stream.
            Stream dataStream = request.GetRequestStream();
            // Write the data to the request stream.
            dataStream.Write(byteArray, 0, byteArray.Length);
            // Close the Stream object.
            dataStream.Close();

            // Get the response.
            WebResponse response = request.GetResponse();
          
            // Get the stream containing content returned by the server.
            // The using block ensures the stream is automatically closed.
            using (dataStream = response.GetResponseStream())
            {
                // Open the stream using a StreamReader for easy access.
                StreamReader reader = new StreamReader(dataStream);
                // Read the content.
                string responseFromServer = reader.ReadToEnd();
                this.result = JsonConvert.DeserializeObject<JsonResultResponse>(responseFromServer);
            }

            // Close the response.
            response.Close();

            
           
        }
    }
}
