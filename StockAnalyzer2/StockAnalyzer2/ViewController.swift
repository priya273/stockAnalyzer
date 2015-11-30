//
//  ViewController.swift
//  StockAnalyzer2
//
//  Created by Naga sarath Thodime on 11/29/15.
//  Copyright © 2015 Priyadarshini Ragupathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController

{
    
   let Positions = [0,0.004,0.008,0.012,0.016,0.02,0.023,0.027,0.031,0.035,0.039,0.043,0.047,0.051,0.055,0.059,0.063,0.066,0.074,0.078,0.082,0.086,0.094,0.098,0.102,0.105,0.109,0.113,0.117,0.121,0.125,0.129,0.133,0.141,0.145,0.148,0.152,0.156,0.16,0.164,0.168,0.172,0.176,0.18,0.184,0.188,0.191,0.195,0.199,0.203,0.207,0.211,0.219,0.223,0.227,0.23,0.234,0.238,0.242,0.246,0.25,0.254,0.258,0.262,0.266,0.27,0.273,0.277,0.281,0.285,0.289,0.293,0.297,0.301,0.305,0.309,0.313,0.316,0.32,0.324,0.328,0.332,0.336,0.34,0.344,0.352,0.355,0.359,0.363,0.367,0.371,0.375,0.379,0.383,0.387,0.391,0.395,0.398,0.402,0.406,0.41,0.414,0.418,0.422,0.426,0.43,0.434,0.438,0.441,0.445,0.449,0.453,0.457,0.461,0.465,0.469,0.473,0.477,0.48,0.484,0.492,0.496,0.5,0.504,0.508,0.512,0.516,0.52,0.523,0.527,0.531,0.535,0.539,0.543,0.547,0.551,0.555,0.559,0.563,0.566,0.57,0.574,0.578,0.582,0.586,0.59,0.594,0.598,0.602,0.605,0.609,0.613,0.617,0.621,0.625,0.629,0.633,0.637,0.641,0.645,0.648,0.652,0.656,0.66,0.664,0.668,0.672,0.676,0.68,0.684,0.688,0.691,0.695,0.699,0.703,0.707,0.711,0.715,0.719,0.723,0.727,0.73,0.734,0.738,0.742,0.746,0.75,0.754,0.758,0.762,0.766,0.77,0.773,0.777,0.781,0.785,0.789,0.793,0.797,0.801,0.805,0.809,0.813,0.816,0.82,0.824,0.828,0.832,0.836,0.84,0.844,0.848,0.852,0.855,0.859,0.863,0.867,0.871,0.875,0.879,0.883,0.887,0.891,0.895,0.898,0.902,0.906,0.91,0.914,0.918,0.922,0.926,0.93,0.934,0.938,0.941,0.945,0.949,0.953,0.957,0.961,0.965,0.969,0.973,0.977,0.98,0.984,0.988,0.992,0.996,1]
    
     let Dates = ["2014-12-01T00:00:00","2014-12-02T00:00:00","2014-12-03T00:00:00","2014-12-04T00:00:00","2014-12-05T00:00:00","2014-12-08T00:00:00","2014-12-09T00:00:00","2014-12-10T00:00:00","2014-12-11T00:00:00","2014-12-12T00:00:00","2014-12-15T00:00:00","2014-12-16T00:00:00","2014-12-17T00:00:00","2014-12-18T00:00:00","2014-12-19T00:00:00","2014-12-22T00:00:00","2014-12-23T00:00:00","2014-12-24T00:00:00","2014-12-26T00:00:00","2014-12-29T00:00:00","2014-12-30T00:00:00","2014-12-31T00:00:00","2015-01-02T00:00:00","2015-01-05T00:00:00","2015-01-06T00:00:00","2015-01-07T00:00:00","2015-01-08T00:00:00","2015-01-09T00:00:00","2015-01-12T00:00:00","2015-01-13T00:00:00","2015-01-14T00:00:00","2015-01-15T00:00:00","2015-01-16T00:00:00","2015-01-20T00:00:00","2015-01-21T00:00:00","2015-01-22T00:00:00","2015-01-23T00:00:00","2015-01-26T00:00:00","2015-01-27T00:00:00","2015-01-28T00:00:00","2015-01-29T00:00:00","2015-01-30T00:00:00","2015-02-02T00:00:00","2015-02-03T00:00:00","2015-02-04T00:00:00","2015-02-05T00:00:00","2015-02-06T00:00:00","2015-02-09T00:00:00","2015-02-10T00:00:00","2015-02-11T00:00:00","2015-02-12T00:00:00","2015-02-13T00:00:00","2015-02-17T00:00:00","2015-02-18T00:00:00","2015-02-19T00:00:00","2015-02-20T00:00:00","2015-02-23T00:00:00","2015-02-24T00:00:00","2015-02-25T00:00:00","2015-02-26T00:00:00","2015-02-27T00:00:00","2015-03-02T00:00:00","2015-03-03T00:00:00","2015-03-04T00:00:00","2015-03-05T00:00:00","2015-03-06T00:00:00","2015-03-09T00:00:00","2015-03-10T00:00:00","2015-03-11T00:00:00","2015-03-12T00:00:00","2015-03-13T00:00:00","2015-03-16T00:00:00","2015-03-17T00:00:00","2015-03-18T00:00:00","2015-03-19T00:00:00","2015-03-20T00:00:00","2015-03-23T00:00:00","2015-03-24T00:00:00","2015-03-25T00:00:00","2015-03-26T00:00:00","2015-03-27T00:00:00","2015-03-30T00:00:00","2015-03-31T00:00:00","2015-04-01T00:00:00","2015-04-02T00:00:00","2015-04-06T00:00:00","2015-04-07T00:00:00","2015-04-08T00:00:00","2015-04-09T00:00:00","2015-04-10T00:00:00","2015-04-13T00:00:00","2015-04-14T00:00:00","2015-04-15T00:00:00","2015-04-16T00:00:00","2015-04-17T00:00:00","2015-04-20T00:00:00","2015-04-21T00:00:00","2015-04-22T00:00:00","2015-04-23T00:00:00","2015-04-24T00:00:00","2015-04-27T00:00:00","2015-04-28T00:00:00","2015-04-29T00:00:00","2015-04-30T00:00:00","2015-05-01T00:00:00","2015-05-04T00:00:00","2015-05-05T00:00:00","2015-05-06T00:00:00","2015-05-07T00:00:00","2015-05-08T00:00:00","2015-05-11T00:00:00","2015-05-12T00:00:00","2015-05-13T00:00:00","2015-05-14T00:00:00","2015-05-15T00:00:00","2015-05-18T00:00:00","2015-05-19T00:00:00","2015-05-20T00:00:00","2015-05-21T00:00:00","2015-05-22T00:00:00","2015-05-26T00:00:00","2015-05-27T00:00:00","2015-05-28T00:00:00","2015-05-29T00:00:00","2015-06-01T00:00:00","2015-06-02T00:00:00","2015-06-03T00:00:00","2015-06-04T00:00:00","2015-06-05T00:00:00","2015-06-08T00:00:00","2015-06-09T00:00:00","2015-06-10T00:00:00","2015-06-11T00:00:00","2015-06-12T00:00:00","2015-06-15T00:00:00","2015-06-16T00:00:00","2015-06-17T00:00:00","2015-06-18T00:00:00","2015-06-19T00:00:00","2015-06-22T00:00:00","2015-06-23T00:00:00","2015-06-24T00:00:00","2015-06-25T00:00:00","2015-06-26T00:00:00","2015-06-29T00:00:00","2015-06-30T00:00:00","2015-07-01T00:00:00","2015-07-02T00:00:00","2015-07-06T00:00:00","2015-07-07T00:00:00","2015-07-08T00:00:00","2015-07-09T00:00:00","2015-07-10T00:00:00","2015-07-13T00:00:00","2015-07-14T00:00:00","2015-07-15T00:00:00","2015-07-16T00:00:00","2015-07-17T00:00:00","2015-07-20T00:00:00","2015-07-21T00:00:00","2015-07-22T00:00:00","2015-07-23T00:00:00","2015-07-24T00:00:00","2015-07-27T00:00:00","2015-07-28T00:00:00","2015-07-29T00:00:00","2015-07-30T00:00:00","2015-07-31T00:00:00","2015-08-03T00:00:00","2015-08-04T00:00:00","2015-08-05T00:00:00","2015-08-06T00:00:00","2015-08-07T00:00:00","2015-08-10T00:00:00","2015-08-11T00:00:00","2015-08-12T00:00:00","2015-08-13T00:00:00","2015-08-14T00:00:00","2015-08-17T00:00:00","2015-08-18T00:00:00","2015-08-19T00:00:00","2015-08-20T00:00:00","2015-08-21T00:00:00","2015-08-24T00:00:00","2015-08-25T00:00:00","2015-08-26T00:00:00","2015-08-27T00:00:00","2015-08-28T00:00:00","2015-08-31T00:00:00","2015-09-01T00:00:00","2015-09-02T00:00:00","2015-09-03T00:00:00","2015-09-04T00:00:00","2015-09-08T00:00:00","2015-09-09T00:00:00","2015-09-10T00:00:00","2015-09-11T00:00:00","2015-09-14T00:00:00","2015-09-15T00:00:00","2015-09-16T00:00:00","2015-09-17T00:00:00","2015-09-18T00:00:00","2015-09-21T00:00:00","2015-09-22T00:00:00","2015-09-23T00:00:00","2015-09-24T00:00:00","2015-09-25T00:00:00","2015-09-28T00:00:00","2015-09-29T00:00:00","2015-09-30T00:00:00","2015-10-01T00:00:00","2015-10-02T00:00:00","2015-10-05T00:00:00","2015-10-06T00:00:00","2015-10-07T00:00:00","2015-10-08T00:00:00","2015-10-09T00:00:00","2015-10-12T00:00:00","2015-10-13T00:00:00","2015-10-14T00:00:00","2015-10-15T00:00:00","2015-10-16T00:00:00","2015-10-19T00:00:00","2015-10-20T00:00:00","2015-10-21T00:00:00","2015-10-22T00:00:00","2015-10-23T00:00:00","2015-10-26T00:00:00","2015-10-27T00:00:00","2015-10-28T00:00:00","2015-10-29T00:00:00","2015-10-30T00:00:00","2015-11-02T00:00:00","2015-11-03T00:00:00","2015-11-04T00:00:00","2015-11-05T00:00:00","2015-11-06T00:00:00","2015-11-09T00:00:00","2015-11-10T00:00:00","2015-11-11T00:00:00","2015-11-12T00:00:00","2015-11-13T00:00:00","2015-11-16T00:00:00","2015-11-17T00:00:00","2015-11-18T00:00:00","2015-11-19T00:00:00","2015-11-20T00:00:00","2015-11-23T00:00:00","2015-11-24T00:00:00","2015-11-25T00:00:00","2015-11-27T00:00:00"]
    
        let currency = "USD"
        //let TimeStamp = null
    
        let Symbol = "AAPL"
    
        let Type = "price"
    
        let close = [115.07,114.63,115.93,115.49,115,112.4,114.12,111.95,111.62,109.73,108.225,106.745,109.41,112.65,111.78,112.94,112.54,112.01,113.99,113.91,112.52,110.38,109.33,106.25,106.26,107.75,111.89,112.01,109.25,110.22,109.8,106.82,105.99,108.72,109.55,112.4,112.98,113.1,109.14,115.31,118.9,117.16,118.63,118.65,119.56,119.94,118.93,119.72,122.02,124.88,126.46,127.08,127.83,128.715,128.45,129.495,133,132.17,128.79,130.415,128.46,129.09,129.36,128.54,126.41,126.6,127.14,124.51,122.24,124.45,123.59,124.95,127.04,128.47,127.495,125.9,127.21,126.69,123.38,124.24,123.25,126.37,124.43,124.25,125.32,127.35,126.01,125.6,126.56,127.1,126.85,126.3,126.78,126.17,124.75,127.6,126.91,128.62,129.67,130.28,132.65,130.56,128.64,125.15,128.95,128.7,125.8,125.01,125.26,127.62,126.32,125.865,126.01,128.95,128.77,130.19,130.07,130.06,131.39,132.54,129.62,132.045,131.78,130.28,130.535,129.96,130.12,129.36,128.65,127.8,127.42,128.88,128.59,127.17,126.92,127.6,127.3,127.88,126.6,127.61,127.03,128.11,127.5,126.75,124.53,125.425,126.6,126.44,126,125.69,122.57,120.07,123.28,125.66,125.61,126.82,128.51,129.62,132.07,130.75,125.22,125.16,124.5,122.77,123.38,122.99,122.37,121.3,118.44,114.64,115.4,115.13,115.52,119.72,113.49,115.24,115.15,115.96,117.16,116.5,115.01,112.65,105.76,103.12,103.74,109.69,112.92,113.29,112.76,107.72,112.34,110.37,109.27,112.31,110.15,112.57,114.21,115.31,116.28,116.41,113.92,113.45,115.21,113.4,114.32,115,114.71,112.44,109.06,110.3,109.58,110.38,110.78,111.31,110.78,109.5,112.12,111.6,111.79,110.21,111.86,111.04,111.73,113.77,113.76,115.5,119.08,115.28,114.55,119.27,120.53,119.5,121.18,122.57,122,120.92,121.06,120.57,116.77,116.11,115.72,112.34,114.175,113.69,117.29,118.78,119.3,117.75,118.88,118.03,117.82]
    
      let min = 103.12
    let max = 133
    let maxDate = "2015-02-23T00:00:00"
    let minDate = "2015-08-24T00:00:00"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

