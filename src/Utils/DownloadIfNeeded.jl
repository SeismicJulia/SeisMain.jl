using Downloads
using SHA

"""
    download_if_needed(url::String, output::String, sha256sum::String)

Download the file from `url` to `output` if the file is not already present
or if its SHA256 checksum does not match the `sha256sum`.

# Arguments
- `url::String`: The URL from which to download the file.
- `output::String`: The path where the downloaded file will be saved.

# Keyword arguments
- `sha256sum::String`: The expected SHA256 checksum of the file to ensure its integrity.

# Output
- `nothing`: This function returns `nothing`. It performs the side effect of downloading a file and verifying its checksum. If the checksum does not match, the function raises an error and deletes the downloaded file.

*Credits: Átila Saraiva Quintela Soares, 2024*
"""
function download_if_needed(url::String, output::String; sha256sum::String)
    file_exists = isfile(output)

    if file_exists
        file_sha256 = open(output) do io
            io |> sha256 |> bytes2hex
        end
        if file_sha256 == sha256sum
            return nothing
        else
            @warn("File exists but checksum does not match. Downloading again.")
        end
    end

    # Download the file
    Downloads.download(url, output)

    # Verify checksum of the downloaded file
    open(output) do io
        file_sha256 = io |> sha256 |> bytes2hex
        if file_sha256 != sha256sum
            rm(output)
            error("Downloaded file checksum does not match the expected checksum.")
        end
    end

    return nothing
end

