# jsonifyFileTree
A perl script to convert a file tree into a JSON format

### Dependencies
- JSON (install using `cpan install JSON`)
- Digest::MD5::File (install using `cpan install Digest::MD5::File`)

### Usage
`./jsonifyFileTree.pl [--hash] [DIRECTORY]`

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
***Files are represented with a hash as a value or null if `--hash` is omitted, while an empty folder has a value of an empty dictionary*
