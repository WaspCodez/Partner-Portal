using Npgsql;
using System.Data;

namespace PhinityPartnerPortal
{
  public class DapperAdapter
  {
    private readonly string _pgConnection;
    public ConfigurationBuilder _configuration = new ConfigurationBuilder();

    public DapperAdapter()
    {
      _pgConnection = "Host=localhost;username=postgres;password=ubu.1900;database=phinity;Include Error Detail=true";// _configuration.Properties["ConnectionStrings:local"].ToString();
    }

    public int Execute(string function, object? param = null)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var result = dbConnection.Execute(function, param, commandType: CommandType.StoredProcedure);
        return result;
      }
    }

    public async Task<int> ExecuteAsync(string function, object? param = null)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var result = await dbConnection.ExecuteAsync(function, param, commandType: CommandType.StoredProcedure);
        return result;
      }
    }

    public IEnumerable<T> Query<T>(string function, object? param = null)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var result = dbConnection.Query<T>(function, param, commandType: CommandType.StoredProcedure);
        return result;
      }
    }

    public async Task<IEnumerable<T>> QueryAsync<T>(string function, object? param = null)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var result = await dbConnection.QueryAsync<T>(function, param, commandType: CommandType.StoredProcedure);
        return result;
      }
    }

    public async Task<IEnumerable<T>> QuerySqlAsync<T>(string sql)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var result = await dbConnection.QueryAsync<T>(sql);
        return result;
      }
    }

    public async Task<string> ExtractCSVAsync(string function)
    {
      using (var dbConnection = new NpgsqlConnection(_pgConnection))
      {
        dbConnection.Open();
        var reader = dbConnection.BeginTextExport(function);
        var result = await reader.ReadToEndAsync();
        return result;
      }
    }
  }
}