irods_policy_list_thumbnails_for_logical_path(*params, *config, *out)
{
    #*out = '{"key": "hello, world!"}';
    *out = '{ "location": "testLocation", "items": [ { "id": 1, "name": "sample1.png", "lastModified": "2020-12-14", "thumbnails": "./img/sample1.jpg" }, { "id": 2, "name": "sample2.png", "lastModified": "2020-12-14", "thumbnails": "./img/sample2.jpg" }, { "id": 3, "name": "sample3.png", "lastModified": "2020-12-14", "thumbnails": "./img/sample3.jpg" }] }'
}
