# coding=utf-8
from selenium import webdriver
from requests import Session
from time import sleep
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
import sys
import warnings

# 屏蔽警告
warnings.filterwarnings("ignore", category=Warning)

# 接收外部参数并输入Chrome
try:
    workname = sys.argv[1]
    password = sys.argv[2]
    enterprise = sys.argv[3]
except IndexError:
    workname = "xxx"
    password = "xxx"
    enterprise = "xxx"
try:
    server = sys.argv[4]
except IndexError:
    server = "xxx"
# 打开Chrome
options = webdriver.ChromeOptions()
options.add_argument('--no-sandbox')
options.add_argument('--headless')
options.add_argument('--disable-dev-shm-usage')
wd = webdriver.Chrome(chrome_options=options)
authLogInUrl = 'https://{0}.xxx.com/'.format(server, )
wd.get(authLogInUrl)


sleep(0.2)
wd.find_element_by_xpath('//*[@id="login"]/div/div[1]/div/input[2]').send_keys(workname)
sleep(0.2)
wd.find_element_by_xpath('//*[@id="login"]/div/div[2]/div/input').send_keys(password)
sleep(0.2)
wd.find_element_by_xpath('//*[@id="login"]/div/div[3]/div/input').send_keys(enterprise)
sleep(1)
wd.find_element_by_xpath('//*[@id="login"]/div/div[7]/button').click()

# 对公告弹窗执行ESC
sleep(5)
try:
    wd.find_element_by_xpath('/html/body/div[6]/div/div[2]').send_keys(Keys.ESCAPE)
except:
    pass


def login_error_div(Xpath):
    div = wd.find_elements_by_xpath(Xpath)
    for li_i in div:
        print(li_i.text)


def print_p_div(text_1):
    try:
        sleep(1)
        Xpath_3 = '//*[@id="container"]/div/div/div[2]/div[2]/div[3]'
        div = wd.find_elements_by_xpath(Xpath_3)
        for li_i in div:
            # print(li_i.text)
            if "异常" in li_i.text:
                print("进入" + text_1 + "失败,出错信息:")
                print(li_i.text)
            else:
                print("正常进入"+text_1)
    except Exception:
        Xpath_3 = '//*[@id="container"]/div/div/div[2]/div[2]/div[3]'
        login_error_div(Xpath_3)


def print_web_div(j):
    k = j
    m = 1
    while 1:
        sleep(0.5)
        try:
            Xpath_1 = '//*[@id="0{0}$Menu"]/li[{1}]'.format(k, m, )
            wd.find_element_by_xpath(Xpath_1).click()
            sleep(1)
            text_1 = wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text
            print("正在进入"+text_1+":")
            print_p_div(text_1)
            print('---------------------------------------------------------------------------------------------------')
            m = m + 1
        except Exception:
            break


def print_web(i_2):
    j = i_2
    k = j + 1
    sleep(1)
    Xpath_2 = '//*[@id="container"]/div/div/div[1]/div/ul/li[{0}]'.format(k, )
    wd.find_element_by_xpath(Xpath_2).click()
    print_web_div(j)


# 进入首页，未进入就输出报错信息
sleep(1)
try:
    a = wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[2]/span[1]/a').text
    if a == "xxx":
        print("xxx")
except Exception:
    login_error_div('//*[@id="login"]/div/div[5]')
    login_error_div('// *[ @ id = "container"]')
    wd.quit()
    exit()
else:
    pass

# wd.quit()
# exit()

# 打开导航栏
sleep(1)
wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div/div[1]').click()

# 登录后检查
for i in list(set(range(1, 9)) - set(range(3, 4))):
    # print_web(i)
    try:
        print_web(i)
    except NameError:
        print("语法错误，请检查")

wd.quit()
exit()
