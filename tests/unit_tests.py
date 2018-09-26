import unittest
import subprocess

def call(cmd):
    return subprocess.call(cmd, stderr=subprocess.STDOUT, shell=True)

def check_call(cmd):
    return subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=True)

def check_output(cmd):
    return subprocess.check_output(cmd, stderr=subprocess.STDOUT, shell=True)

class NFSRODSTests(unittest.TestCase):

    #mount_point = "/mnt/nfsrods"
    #mount_port  = "2050"

    def setUp(self):
        # Set up mount point.
        # Authenticate with Kerberos server.
        #check_call("[ ! -d '{0}' ] && mkdir {0}".format(NFSRODSTests.mount_point))
        #check_call("sudo mount -o sec=krb5,port={1} $(hostname):/ {0}".format(NFSRODSTests.mount_point, NFSRODSTests.mount_port))
        check_call("echo rods | kinit -f rods")
        #check_call("cd {0}".format(NFSRODSTests.mount_point));
        #pass

    def tearDown(self):
        # Unmount the mount point.
        # Clear Kerberos access.
        #check_call("sudo umount {0}".format(NFSRODSTests.mount_point));
        check_call("kdestroy")
        #pass

    def test_cd(self):
        ec = check_output("echo rods | kinit -f rods && ls -l /mnt/nfsrods/home/rods")
        print("ec =", ec)
        self.assertTrue(True)

    def test_mkdir(self):
        self.assertTrue(True)

    def test_rmdir(self):
        self.assertTrue(True)

    def test_create(self):
        self.assertTrue(True)

    def test_remove(self):
        self.assertTrue(True)

    def test_list(self):
        self.assertTrue(True);

    def test_move(self):
        self.assertTrue(True)

    def test_read(self):
        self.assertTrue(True)

    def test_write(self):
        self.assertTrue(True)

    def test_access(self):
        self.assertTrue(True)

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(NFSRODSTests)
    unittest.TextTestRunner(verbosity=2).run(suite)
