using StackExchange.Redis;

ConnectionMultiplexer redis = await ConnectionMultiplexer.ConnectAsync(
    new ConfigurationOptions
    {
        EndPoints = { "127.0.0.1:6380" },
        Proxy = Proxy.Twemproxy,
        Password = "mypassword"
    });



var db = redis.GetDatabase();
while (true)
{
    var pong = await db.PingAsync();
    Console.WriteLine(pong);

    await Task.Delay(TimeSpan.FromSeconds(1));
}
