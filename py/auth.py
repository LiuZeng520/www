# coding=utf-8
from selenium import webdriver
from requests import Session
from time import sleep
from selenium.webdriver.chrome.options import Options
import pyautogui

req = Session()
req.headers.clear()

# chromePath = r'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
# chromePath = r'google-chrome'
# wd = webdriver.Chrome(executable_path=chromePath)
# authLogInUrl = 'https://xxx.xxx.com/login'
# wd.get(authLogInUrl)

# chromePath = r'/usr/bin/google-chrome'
options = webdriver.ChromeOptions()
options.add_argument('--no-sandbox')
options.add_argument('--disable-dev-shm-usage')
wd = webdriver.Chrome(chrome_options=options)
authLogInUrl = 'https://xxx.xxx.com/login'
wd.get(authLogInUrl)

# wd.find_element_by_xpath('/html/body/div[1]/div/div[2]/div[2]/div[1]/div[1]/div[2]/span').click()
sleep(0.5)
wd.find_element_by_xpath('//*[@id="login"]/div/div[1]/div/input[2]').send_keys('username')
sleep(0.5)
wd.find_element_by_xpath('//*[@id="login"]/div/div[2]/div/input').send_keys('passwd')
sleep(0.5)
wd.find_element_by_xpath('//*[@id="login"]/div/div[3]/div/input').send_keys('odmname')
sleep(0.5)
# wd.find_element_by_xpath('//*[@id="login"]/div/div[7]/button').submit()
wd.find_element_by_xpath('//*[@id="login"]/div/div[7]/button').click()

# try:
#     wd.find_element_by_xpath('//*[@id="login"]/div/div[7]/button').click()
# except:
#     print(wd.find_element_by_xpath('//*[@id="login"]/div/div[1]/div/input[2]').text)
#     exit(10)


# print(wd.find_element_by_xpath('//*[@id="login"]/div/div[5]').text)
# exit()

# sleep(3)
# cookies = wd.get_cookies()
# for cookie in cookies:
#     req.cookies.set(cookie['name'], cookie['value'])

sleep(10)
pyautogui.press('esc')


def p_div(Xpath):
    div = wd.find_elements_by_xpath(Xpath)
    for i in div:
        print(i.text)


# 进入首页，未进入就输出报错信息
try:
    a = wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[2]/span[1]/a').text
    if a == "xxx":
        print("xxx")
except Exception:
    p_div('//*[@id="login"]/div/div[5]')
    wd.quit()
    exit()


def action():
    print("xxx")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[1]/div/div[1]').click()

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[2]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="01$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="01$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="01$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="01$Menu"]/li[4]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[3]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="02$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="02$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[4]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[2]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[5]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="04$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="04$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="04$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="04$Menu"]/li[4]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[6]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[4]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[5]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[6]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[7]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="05$Menu"]/li[8]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[7]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="06$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="06$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[8]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="07$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="07$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="07$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[9]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="08$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="08$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="08$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)

    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="container"]/div/div/div[1]/div/ul/li[10]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="09$Menu"]/li[1]').click()
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="0900$Menu"]/li[1]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[4]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="0900$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[4]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="09$Menu"]/li[2]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="09$Menu"]/li[3]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="09$Menu"]/li[4]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)
    print("xxx:")
    sleep(1)
    wd.find_element_by_xpath('//*[@id="09$Menu"]/li[5]').click()
    print(wd.find_element_by_xpath('//*[@id="container"]/div/div/div[2]/div[2]/div[2]/span[3]/span[1]/a').text)


# action()

# try:
#     action()
# except Exception:
#     print("服务异常")

wd.quit()
exit()
