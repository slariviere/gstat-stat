# Gstat stats

Gather stats to analyse disks read/write delays. Low tech tool to identify failing disks.

# Example

Here is an example of this tool used to identifing performance isssue on raid-z disk array

```
L(q)  ops/s    r/s   kBps   ms/r    w/s   kBps   ms/w   %busy Name
 0.3  168.2  160.2 5247.0    3.6    7.7   21.4    0.8   15.4  ada0
 0.3  169.9  161.9 5246.1    3.2    7.7   21.5    0.8   14.9  ada1
 0.3  165.3  157.2 5247.1    3.4    7.7   21.4    0.7   15.7  ada2
 0.0    0.4    0.0    0.0    0.0    0.4   13.9    0.2    0.0  ada3
 0.3  173.7  165.7 5242.3    3.1    7.7   21.4    0.8   14.7  ada4
 1.8  143.3  135.1 5256.9  186.5    7.8   21.5   10.6   89.7  ada5
 0.3  166.4  158.5 5248.2    4.1    7.7   21.4    1.1   16.7  ada6
 0.4  142.3  134.1 5249.1    3.2    7.9   21.5    0.4   19.9  ada7
 0.3  168.5  160.4 5244.7    3.5    7.8   21.5    0.9   15.7  ada8
```

Disk ada5 was causing performance was slowing down the disk array.

# Usage

Iterations variable can be change to alter the number of gstat itetation before showing the report.
Disk_identifier can be change to alter the device identifier of disk used.
