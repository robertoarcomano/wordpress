<?php 
$db = new mysqli("localhost","root","","lemp");
if ($db->connect_error) {
        die("Connection failed: " . $db->connect_error);
}
$db->query("delete from users");
for ($i = 0; $i < 10; $i++)
        $result = $db->query("insert into users(name) values('User $i')");

?><table border=1>
<tr> <th>ID</th> <th>NAME</th> </tr>
<?php
$result = $db->query("select * from users");
while ($result->num_rows > 0 && $record = $result->fetch_assoc()) {
        $id = $record['id'];
        $name = $record['name'];
?>
  <tr> <td><?=$id?></td> <td><?=$name?></td> </tr>
<?php } ?>
</table>
