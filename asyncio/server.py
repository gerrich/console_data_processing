from aiohttp import web
import time
import logging
import logging.handlers

def log_setup():
    log_handler = logging.handlers.WatchedFileHandler('server.log')
    formatter = logging.Formatter( '%(asctime)s program_name [%(process)d]: %(message)s', '%b %d %H:%M:%S')
    formatter.converter = time.gmtime  # if you want UTC time
    log_handler.setFormatter(formatter)
    logger = logging.getLogger()
    logger.addHandler(log_handler)
    logger.setLevel(logging.DEBUG)

log_setup()


async def handle(request):
    name = request.match_info.get('name', "Anonymous")
    text = "Hello, " + name
    logging.info('handle({})'.format(name))
    return web.Response(text=text)

app = web.Application()
app.router.add_get('/', handle)
app.router.add_get('/{name}', handle)

web.run_app(app)
