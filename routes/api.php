<?php

use BeyondCode\LaravelWebSockets\Facades\WebSocketsRouter;
use BeyondCode\LaravelWebSockets\Server\Logger\WebsocketsLogger;
use Domain\GraphsWebsocket;
use Domain\EchoTestWebsocket;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

use Symfony\Component\Console\Output\NullOutput;
app()->singleton(WebsocketsLogger::class, function () {
    return (new WebsocketsLogger(new NullOutput()))->enable(false);
}); // fix https://github.com/beyondcode/laravel-websockets/issues/21

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

WebSocketsRouter::webSocket('/ws/echo/', EchoTestWebsocket::class);
