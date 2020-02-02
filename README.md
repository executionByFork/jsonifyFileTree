# jsonifyFileTree
A perl script to convert a file tree into a JSON format

### Dependencies
- JSON

Install using `cpan install JSON`

### Usage
`./jsonifyFileTree [DIRECTORY]`

**Example:**
```
$ ./jsonifyFileTree.pl myfolder/
{
   "file.txt" : null,
   "subdir" : {
      "anotherfile.txt" : null,
      "helloworld.csv" : null
   },
   "emptyfolder" : {}
}
```
***Files are represented a null value while an empty folder has a value of an empty dictionary*
