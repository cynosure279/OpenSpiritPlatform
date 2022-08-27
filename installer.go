package main
import (
	"fmt"
	"strings"
	"net/http"
	"os"
	"io"
	"bufio"
	"runtime"
)
func download(url string) {
	fileurl := strings.Split(url,"/")
	filename := fileurl[len(fileurl)-1]
	fmt.Println("[Tip]:正在下载目标文件",filename)
	res,err := http.Get(url)
	if err != nil {
		fmt.Println("[Err]:",err,"\n[错误]:网络下载发生了以上错误")
	}
	defer res.Body.Close()
	reader := bufio.NewReaderSize(res.Body,32 * 1024)
	fp,err := os.Create(filename)
	if err != nil {
		fmt.Println("[Err]:",err,"\n[错误]:创建文件发生了以上错误")
	}
	writer := bufio.NewWriter(fp)
	io.Copy(writer,reader)
	fmt.Println("[Success]:",filename,"download!")
}

func autochoose(sys string,arch string,sources []string) {
	if sys == "linux"  {
		if arch == "amd64" {
			fmt.Println("[Good]已检测到对应系统和架构的目标文件!\n[Tip]:You are going to download Linux(X86_64) Version!")
			download("http://106.12.151.137:8080/index.php/s/gWFcZ2oKxr8BpGN/download/OpenSpirit.x86_64")
			download("http://106.12.151.137:8080/index.php/s/fNQnM6FrdkYd32z/download/OpenSpirit.pck")
		}
	}else if sys == "windows" {
		if arch == "amd64" {
			fmt.Println("[Good]已检测到对应系统和架构的目标文件!\n[Tip]:You are going to download Windows(X86_64) Desktop Version!")
			download("http://106.12.151.137:8080/index.php/s/pt59NHiG7f8rdPd/download/OpenSpirit.exe")
			download("http://106.12.151.137:8080/index.php/s/fNQnM6FrdkYd32z/download/OpenSpirit.pck")
		}
	}else {
		fmt.Println("[Err]:Unkonwn OS or Architecture,please install by hand!")
		handchoose(sources)
	}
}
func handchoose(sources []string) {
	fmt.Println("[Tip]:Listing object file...")
	fmt.Println("0 -> exit")
	for i := 0 ; i <= len(sources)-1 ; i++ {
		fmt.Println(i+1,"->",sources[i])
	}
	fmt.Println("[Tip]:Finished!Please enter a number to download or enter 0 to exit")
	var number int
	fmt.Scan(&number)
	if number == 0 {
		os.Exit(0)
	}else if 0 < number && number <= len(sources)-1 {
		download(sources[number-1])
		handchoose(sources)
	}else {
		fmt.Println("[Err]:Invalid chosse!")
		handchoose(sources)
	}                                     
}

func readline() ([]string,error) {
	fp, err := os.Open("./files.list")
	if err != nil {
		return nil,err
	}
	reader := bufio.NewReader(fp)
	var sources []string
	for {
		line, err := reader.ReadString('\n')
		line = strings.TrimSpace(line)
		if err != nil {
			if err == io.EOF {
				return sources,nil
			}
			return nil,err
		}
		sources = append(sources,line)
	}
	return sources,nil
}

func main() {
	fmt.Println("[Tip]:OpenSpiritInstaller is running...\n[Welcome]Welcome to use OpenSpirit! \n[Tip]:Updating object-file-list...")
	download("http://106.12.151.137:8080/index.php/s/ig7eDzZE7Ft78mL/download/files.list")
	sources,err := readline()
	if err != nil {
		fmt.Println("[Err]:处理下载源时出现问题...",err)
	}
	hostname,err := os.Hostname()
	if err != nil {
		fmt.Println("[Err]:",err,"\n[错误]:无法获取系统名")
	}
	fmt.Println("[Info]:Hostname:",hostname)
	systype := runtime.GOOS
	sysarch := runtime.GOARCH
	fmt.Println("[Info]:Systeam and Architecture:",systype,"in",sysarch,"\n[Tip]:输入Y或者N以进行选择")
	var choose string
	fmt.Scan(&choose)
	if choose == "Y" {
		autochoose(systype,sysarch,sources)
	}else {
		handchoose(sources)
	}

}
