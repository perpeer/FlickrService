# FlickrService
This application developed without using a storyboard. The first window starts by AppDelegate window property. All api request runs with Service singleton pattern.

## Screenshots
|      Screen      | Detail Screen      |
|:-----------------|-------------------:|
|    ![screen][]   | ![detail-screen][] |


## Sample of api url
- **Photos json url**: 
 https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key={fickr_api_key}&format=json&nojsoncallback=1&safe_search=1&per_page={page_size}&text={search_text}&page={page_num}
 - **Photo image url**: 
 https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

## Sample of api json
Photos json data;

```json
{
  "photos": {
    "page": 1,
    "pages": 1000,
    "perpage": 1,
    "total": 1000,
    "photo": [
      {
        "id": "49084987422",
        "owner": "60946426@N08",
        "secret": "d5d27432bd",
        "server": "65535",
        "farm": 66,
        "title": "Silver_H_027.jpg",
        "ispublic": 1,
        "isfriend": 0,
        "isfamily": 0
      }
    ]
  },
  "stat": "ok"
}
```

[screen]: https://github.com/perpeer/FlickrService/blob/master/images/MainScreen.png?raw=true
[detail-screen]: https://github.com/perpeer/FlickrService/blob/master/images/DetailScreen.png?raw=true
