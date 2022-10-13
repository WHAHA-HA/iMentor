from HTMLParser import HTMLParser

class MLStripper(HTMLParser):
    def __init__(self):
        self.reset()
        self.fed = []
    def handle_data(self, d):
        self.fed.append(d)
    def get_data(self):
        return ' '.join([x.strip() for x in self.fed])

def strip_tags(html):
    if html in ('',None):
        return html

    s = MLStripper()
    s.feed(html)
    return s.get_data()


if __name__ == '__main__':
    print strip_tags("<p>hi</p>blah blah blah<br/><p>b</p><p>b</p>")
