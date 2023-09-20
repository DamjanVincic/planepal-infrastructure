using IdentityModel;
using IdentityModel.Client;
using static IdentityModel.OidcConstants;
using System.Net.Sockets;

Console.ReadLine();
var client = new HttpClient();
var discoveryDocument = await client.GetDiscoveryDocumentAsync("https://localhost:5001");
var token = await client.RequestClientCredentialsTokenAsync(new ClientCredentialsTokenRequest()
{
    Address = discoveryDocument.TokenEndpoint,
    ClientId = "m2m.client",
    ClientSecret = "511536EF-F270-4058-80CA-1C89C192F69A",
    Scope = "scope1"
});

Console.WriteLine($"Token: {token.AccessToken}");