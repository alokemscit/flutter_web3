class ModelTestMainSetup {
  String? id;
  String? name;
  String? status;
  String? deptId;
  String? deptName;
  String? grpId;
  String? grpName;
  String? hid;
  String? headName;

  ModelTestMainSetup(
      {this.id,
      this.name,
      this.status,
      this.deptId,
      this.deptName,
      this.grpId,
      this.grpName,
      this.hid,
      this.headName});

  ModelTestMainSetup.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    status = json['status'].toString();
    deptId = json['dept_id'].toString();
    deptName = json['dept_name'];
    grpId = json['grp_id'].toString();
    grpName = json['grp_name'];
    hid = json['hid'].toString();
    headName = json['head_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['dept_id'] = this.deptId;
    data['dept_name'] = this.deptName;
    data['grp_id'] = this.grpId;
    data['grp_name'] = this.grpName;
    data['hid'] = this.hid;
    data['head_name'] = this.headName;
    return data;
  }
}
