# coding=utf-8
from selenium import webdriver
from requests import Session
from time import sleep
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
import sys

# 接收外部参数并输入Chrome
try:
    workname = sys.argv[1]
    password = sys.argv[2]
    enterprise = sys.argv[3]
except IndexError:
    workname = "admin"
    password = "000000"
    enterprise = "admin001"
try:
    server = sys.argv[4]
except IndexError:
    server = "e"
# 打开Chrome
options = webdriver.ChromeOptions()
options.add_argument('--no-sandbox')
options.add_argument('--headless')
options.add_argument('--disable-dev-shm-usage')
wd = webdriver.Chrome(chrome_options=options)
authLogInUrl = 'https://{0}.jifenzhi.com/'.format(server, )
wd.get(authLogInUrl)


def login_error_div(Xpath):
    div = wd.find_elements_by_xpath(Xpath)
    for li_i in div:
        text_1 = li_i.text
        if text_1 == "account not found":
            print("异常：用户不存在")
        elif text_1 == "password mistake":
            print("异常：密码错误")
        elif text_1 == "company not found":
            print("异常：企业账号不存在")
        else:
            print("异常："+text_1)


try:
    sleep(0.2)
    wd.find_element_by_xpath('//*[@id="login"]/div/div[1]/div/input[2]').send_keys(workname)
    sleep(0.2)
    wd.find_element_by_xpath('//*[@id="login"]/div/div[2]/div/input').send_keys(password)
    sleep(0.2)
    wd.find_element_by_xpath('//*[@id="login"]/div/div[3]/div/input').send_keys(enterprise)
    sleep(1)
    wd.find_element_by_xpath('//*[@id="login"]/div/div[7]/button').click()
except Exception:
    login_error_div('/html/body')
    login_error_div('//*[@id="container"]/div')
    wd.quit()
    exit()


# 对公告弹窗执行ESC
sleep(5)
try:
    wd.find_element_by_xpath('/html/body/div[6]/div/div[2]').send_keys(Keys.ESCAPE)
except:
    pass


# 进入首页，未进入就输出报错信息
sleep(1)
try:
    a = wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[2]/span[1]/a').text
    if a == "工作台":
        print("正常登录{0}".format(authLogInUrl, ))
except Exception:
    login_error_div('//*[@id="login"]/div/div[5]')
    login_error_div('//*[@id="container"]')

wd.quit()
exit()
