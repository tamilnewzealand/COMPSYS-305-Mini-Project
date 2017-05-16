from PIL import Image
im = Image.open("tank.bmp") #Can be many different formats.
pix = im.load()
count = 0
for x in range(32):
    for y in range(32):
            print (str('{0:03x}'.format(count)) + " : "+ str('{0:01x}'.format(pix[x,y])) + ";")
            count = count + 1
