use Subprocess;

cobegin {
  var iceProcess = spawn(['./sim-ice'], stdout=pipeStyle.pipe);
  var oceanProcess = spawn(['./sim-ocean'], stdout=pipeStyle.pipe);
}
iceProcess.wait();
oceanProcess.wait();

